import re

path = r'D:\.gemini\antigravity\scratch\iram-services\src\app\admin\page.tsx'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Add state hooks for saving and modalError
states_block = """  const [showProjectModal, setShowProjectModal] = useState(false);
  const [currentProject, setCurrentProject] = useState<Partial<Project> | null>(null);
  const [saving, setSaving] = useState(false);
  const [modalError, setModalError] = useState<string | null>(null);"""

content = content.replace(
    """  const [showProjectModal, setShowProjectModal] = useState(false);
  const [currentProject, setCurrentProject] = useState<Partial<Project> | null>(null);""",
    states_block
)

# 2. Reset modalError when opening modals
content = content.replace(
    'onClick={() => { setCurrentUser({}); setShowUserModal(true); }}',
    'onClick={() => { setCurrentUser({}); setModalError(null); setShowUserModal(true); }}'
)
content = content.replace(
    'onClick={() => { setCurrentUser({ ...u, titleEn: u.titleEn || u.title || \'\', firstNameEn: u.firstNameEn || u.firstName || \'\', lastNameEn: u.lastNameEn || u.lastName || \'\', shortNameEn: u.shortNameEn || \'\' }); fetchPubAuthors(u.id); setShowUserModal(true); }}',
    'onClick={() => { setCurrentUser({ ...u, titleEn: u.titleEn || u.title || \'\', firstNameEn: u.firstNameEn || u.firstName || \'\', lastNameEn: u.lastNameEn || u.lastName || \'\', shortNameEn: u.shortNameEn || \'\' }); setModalError(null); fetchPubAuthors(u.id); setShowUserModal(true); }}'
)
content = content.replace(
    'onClick={() => { setCurrentProject({ status: \'ONGOING\', budgetInitial: 0, budgetSpent: 0 }); setShowProjectModal(true); }}',
    'onClick={() => { setCurrentProject({ status: \'ONGOING\', budgetInitial: 0, budgetSpent: 0 }); setModalError(null); setShowProjectModal(true); }}'
)
content = content.replace(
    'onClick={() => { setCurrentProject(p); setShowProjectModal(true); }}',
    'onClick={() => { setCurrentProject(p); setModalError(null); setShowProjectModal(true); }}'
)

# 3. Update handleSaveUser
old_save_user = """  const handleSaveUser = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!currentUser) return;

    try {
      const isEdit = !!currentUser.id;
      const url = isEdit ? `/api/users/${currentUser.id}` : '/api/users';
      const method = isEdit ? 'PUT' : 'POST';

      // Auto concat name
      const title = currentUser.titleEn || '';
      const first = currentUser.firstNameEn || '';
      const last = currentUser.lastNameEn || '';
      const name = `${title} ${first} ${last}`.trim().replace(/\\s+/, ' ');

      const payload = {
        ...currentUser,
        name,
        role: 'RESEARCHER',
        changeReason: isEdit ? 'Admin profile update' : 'New researcher registration'
      };

      const res = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json', 'x-performed-by': 'admin' },
        body: JSON.stringify(payload)
      });

      if (!res.ok) throw new Error('บันทึกข้อมูลล้มเหลว');

      setMessage({ type: 'success', text: isEdit ? 'อัปเดตข้อมูลนักวิจัยสำเร็จ' : 'เพิ่มนักวิจัยใหม่สำเร็จ' });
      setShowUserModal(false);
      fetchData();
    } catch (err: any) {
      setMessage({ type: 'error', text: err.message });
    }
  };"""

new_save_user = """  const handleSaveUser = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!currentUser) return;
    setSaving(true);
    setModalError(null);

    try {
      const isEdit = !!currentUser.id;
      const url = isEdit ? `/api/users/${currentUser.id}` : '/api/users';
      const method = isEdit ? 'PUT' : 'POST';

      // Auto concat name
      const title = currentUser.titleEn || '';
      const first = currentUser.firstNameEn || '';
      const last = currentUser.lastNameEn || '';
      const name = `${title} ${first} ${last}`.trim().replace(/\\s+/, ' ');

      const payload = {
        ...currentUser,
        name,
        role: 'RESEARCHER',
        changeReason: isEdit ? (currentUser.changeReason || 'Profile update') : 'New researcher registration'
      };

      const res = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json', 'x-performed-by': 'admin' },
        body: JSON.stringify(payload)
      });

      if (!res.ok) {
        const errData = await res.json();
        throw new Error(errData.error || 'บันทึกข้อมูลล้มเหลว');
      }

      setMessage({ type: 'success', text: isEdit ? 'อัปเดตข้อมูลนักวิจัยสำเร็จ' : 'เพิ่มนักวิจัยใหม่สำเร็จ' });
      setShowUserModal(false);
      fetchData();
    } catch (err: any) {
      setModalError(err.message);
    } finally {
      setSaving(false);
    }
  };"""

content = content.replace(old_save_user, new_save_user)

# 4. Update handleSaveProject
old_save_project = """  const handleSaveProject = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!currentProject) return;

    try {
      const isEdit = !!currentProject.id;
      const url = isEdit ? `/api/projects/${currentProject.id}` : '/api/projects';
      const method = isEdit ? 'PUT' : 'POST';

      const res = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json', 'x-performed-by': 'admin' },
        body: JSON.stringify(currentProject)
      });

      if (!res.ok) throw new Error('บันทึกข้อมูลโครงการล้มเหลว');

      setMessage({ type: 'success', text: isEdit ? 'อัปเดตข้อมูลโครงการสำเร็จ' : 'เพิ่มโครงการวิจัยสำเร็จ' });
      setShowProjectModal(false);
      fetchData();
    } catch (err: any) {
      setMessage({ type: 'error', text: err.message });
    }
  };"""

new_save_project = """  const handleSaveProject = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!currentProject) return;
    setSaving(true);
    setModalError(null);

    try {
      const isEdit = !!currentProject.id;
      const url = isEdit ? `/api/projects/${currentProject.id}` : '/api/projects';
      const method = isEdit ? 'PUT' : 'POST';

      const res = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json', 'x-performed-by': 'admin' },
        body: JSON.stringify(currentProject)
      });

      if (!res.ok) {
        const errData = await res.json();
        throw new Error(errData.error || 'บันทึกข้อมูลโครงการล้มเหลว');
      }

      setMessage({ type: 'success', text: isEdit ? 'อัปเดตข้อมูลโครงการสำเร็จ' : 'เพิ่มโครงการวิจัยสำเร็จ' });
      setShowProjectModal(false);
      fetchData();
    } catch (err: any) {
      setModalError(err.message);
    } finally {
      setSaving(false);
    }
  };"""

content = content.replace(old_save_project, new_save_project)

# 5. Render error message banner and disable save button in Modals
content = content.replace(
    '<form onSubmit={handleSaveUser} className="p-6 space-y-6">',
    """<form onSubmit={handleSaveUser} className="p-6 space-y-6">
              {modalError && (
                <div className="p-3 bg-rose-50 border border-rose-200 text-rose-800 rounded-lg text-xs font-bold flex items-center gap-2">
                  <AlertCircle size={14} /> {modalError}
                </div>
              )}"""
)

content = content.replace(
    '<button type="submit" className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg text-sm transition-colors flex items-center gap-1"><Save size={16}/> บันทึกข้อมูล</button>',
    '<button type="submit" disabled={saving} className="bg-blue-600 hover:bg-blue-700 disabled:opacity-50 text-white font-bold py-2 px-4 rounded-lg text-sm transition-colors flex items-center gap-1"><Save size={16}/> {saving ? "กำลังบันทึก..." : "บันทึกข้อมูล"}</button>'
)

content = content.replace(
    '<form onSubmit={handleSaveProject} className="p-6 space-y-6">',
    """<form onSubmit={handleSaveProject} className="p-6 space-y-6">
              {modalError && (
                <div className="p-3 bg-rose-50 border border-rose-200 text-rose-800 rounded-lg text-xs font-bold flex items-center gap-2">
                  <AlertCircle size={14} /> {modalError}
                </div>
              )}"""
)

content = content.replace(
    '<button type="submit" className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg text-sm transition-colors flex items-center gap-1"><Save size={16}/> บันทึกโครงการ</button>',
    '<button type="submit" disabled={saving} className="bg-blue-600 hover:bg-blue-700 disabled:opacity-50 text-white font-bold py-2 px-4 rounded-lg text-sm transition-colors flex items-center gap-1"><Save size={16}/> {saving ? "กำลังบันทึก..." : "บันทึกโครงการ"}</button>'
)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print("page.tsx updated with saving states via exact replace!")
